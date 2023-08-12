ARG MELTANO_IMAGE=meltano/meltano:latest
FROM $MELTANO_IMAGE

WORKDIR /project

# Install any additional requirements
COPY ./requirements.txt .
RUN pip install -r requirements.txt

RUN apt-get update && apt-get -y install libpq-dev gcc && pip install psycopg2

RUN apt-get update && apt-get -y install vim 

COPY . .
# Copy over Meltano project directory
RUN meltano install

# Don't allow changes to containerized project files
#ENV MELTANO_PROJECT_READONLY 1

# Expose default port used by `meltano ui`
EXPOSE 5000
 
WORKDIR "/project"
  
ENTRYPOINT ["tail", "-f", "/dev/null"]
