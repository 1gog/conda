FROM centos:7 as base
RUN yum install epel-release -y && yum install git wget curl jq yq vim python-pip -y && yum clean all -y


FROM base as conda 

ADD condarpm.sh /root/
RUN bash /root/condarpm.sh
RUN yum install conda -y

FROM conda as create_profile 

ENV PATH=$PATH:/opt/conda/bin
RUN conda init && . /root/.bashrc 
RUN conda create -y -n py36 python=3.6

FROM create_profile as second 

RUN . /root/.bashrc && conda activate py36
RUN pip install --upgrade pip && pip install mlflow 

FROM second 

ENV LANG=en_US.utf8
ENV LC_LANG=en_US.utf8
RUN . /root/.bashrc && conda activate py36 && pip install --upgrade pip && pip install mlflow

RUN mkdir -p /opt/app
ADD run.sh /opt/app/
ENTRYPOINT /opt/app/run.sh
