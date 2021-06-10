
FROM rasa/rasa-sdk:latest 

COPY actions actions/
COPY data data/
COPY models models/
COPY config.yml /
COPY credentials.yml /
COPY domain.yml /
COPY endpoints.yml /

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

RUN chmod -R 777 /.config/

USER 1001

EXPOSE 5005
