awk '/WRN/ || /INF/ {gsub(/WRN/, "Warning"); gsub(/INF/, "Information"); pring}' /var/log/anaconda/anaconda.log
