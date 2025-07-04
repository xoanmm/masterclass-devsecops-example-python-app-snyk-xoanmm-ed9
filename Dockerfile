FROM python:3.12.11-alpine3.22

WORKDIR /service/app

COPY requirements.txt /service/app
COPY application /service/app/application
COPY config /service/app/config
COPY app.py /service/app

RUN apk --no-cache add curl build-base npm
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

ENV PYTHONUNBUFFERED=1

HEALTHCHECK --timeout=30s --interval=1m30s --retries=5 \
  CMD curl -s --fail http://localhost:8081/health || exit 1

CMD ["python3", "-u", "app.py"]
