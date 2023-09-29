# Dockerfile
FROM python:3.8
WORKDIR /app
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt
COPY app.py .
EXPOSE 6000
CMD ["python", "app.py"]
