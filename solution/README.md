1. docker logs -f containerID
2024/11/18 12:25:48 error while reading the file "/csvserver/inputdata": open /csvserver/inputdata: no such file or directory

2. echo "1,2,3" > inputdata
    $(pwd)/inputdata refers to the full path of the inputdata file in my current directory.

   $ docker run -v $(pwd)/inputdata:/csvserver/inputdata infracloudio/csvserver:latest
   2024/11/18 12:30:20 listening on ****

3. $ ./gencsv.sh 2 8
File 'inputFile' generated successfully with 7 entries.

$ cat inputFile 
2, 196
3, 728
4, 933
5, 952
6, 371
7, 416
8, 320

4. $ docker run -d -v $(pwd)/inputFile:/csvserver/inputdata infracloudio/csvserver:latest

5. #find the port on which the application is listening

	$ docker exec -it containerID /bin/bash
	[root@fd1f67db2892 csvserver]# netstat -tuln
	Active Internet connections (only servers)
	Proto Recv-Q Send-Q Local Address           Foreign Address         State      
	tcp6       0      0 :::9300                 :::*                    LISTEN   

6. $ docker run -d -v $(pwd)/inputFile:/csvserver/inputdata -p 9393:9300 -e CSVSERVER_BORDER=Orange infracloudio/csvserver:latest

	$ docker exec -it cc64b950152f printenv CSVSERVER_BORDER
	  Orange

	curl -o ./part-1-output http://localhost:9393/raw
	  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
		100   130  100   130    0     0   163k      0 --:--:-- --:--:-- --:--:--  126k

	cat part-1-output 
	Y3N2c2VydmVyIGdlbmVyYXRlZCBhdDogMTczMTk0NzYyMg==
	CSVSERVER_BORDER: Orange
	2,  196
	3,  728
	4,  933
	5,  952
	6,  371
	7,  416
	8,  320

