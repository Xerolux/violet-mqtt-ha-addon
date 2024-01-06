FROM python:3.11-slim

COPY . /addon

WORKDIR /addon

RUN pip install -r requirements.txt

CMD ["/bin/bash", "run.sh"]