FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

RUN addgroup --system --gid 10001 app \
 && adduser  --system --uid 10001 --ingroup app app

COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app/ .

EXPOSE 8080

USER 10001:10001

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]
