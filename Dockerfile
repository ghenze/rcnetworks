FROM yangyangfu/fncs:modelica

RUN pip install pandas
Run pip install sklearn

COPY RCNetworks /usr/local/JModelica/ThirdParty/MSL/RCNetworks