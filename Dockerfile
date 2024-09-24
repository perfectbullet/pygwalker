FROM continuumio/anaconda3:latest as base

WORKDIR /root/pygwalker
COPY . /root/pygwalker/

RUN conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/ && \
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/ && \
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/pytorch/ && \
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/pytorch/linux-64/ && \
conda config --set show_channel_urls yes

RUN conda create -n pygwalker
#RUN conda env update -f environment.yml
# 用于激活环境，conda activate命令无效
SHELL ["conda", "run", "-n", "pygwalker", "/bin/bash", "-c"]
# 成功激活
# RUN conda activate pygwalker
# RUN conda env update -n pygwalker --file environment.yml
RUN conda install -y -c conda-forge pygwalker
RUN conda install jupyterlab
EXPOSE 8859

ENTRYPOINT ["python3", "-m", "jupyterlab", "--allow-root", "--ip=0.0.0.0", "--port=8859"]
