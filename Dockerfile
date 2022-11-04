FROM python:3.9.2

RUN apt update && apt-get install -y \
	gcc \
	default-libmysqlclient-dev \
	python-dev 
	
COPY . .

RUN pip install -r requirements.txt

EXPOSE 81

CMD ["python", "App.py"]