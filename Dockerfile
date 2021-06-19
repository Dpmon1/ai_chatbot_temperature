
FROM rasa/rasa-sdk:latest 




WORKDIR /app

COPY ./actions /app/actions/
COPY ./data /app/data/
COPY ./models /app/models/

COPY config.yml /app
COPY credentials.yml /app
COPY domain.yml /app
COPY endpoints.yml /app

USER root

RUN pip install rasa 
RUN pip install rasa_core 
RUN pip install rasa_core_sdk 
RUN pip install requests 
RUN pip install spacy

RUN python -m spacy download en_core_web_md

RUN mkdir /.config
RUN mkdir /.config/rasa
RUN mkdir /.config/matplotlib

USER 1001

EXPOSE 5005