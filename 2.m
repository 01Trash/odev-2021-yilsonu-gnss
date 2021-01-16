clear; close all; clc;


%%% IGS BROADCAST EPHEMERIS FILE verileri

t sinyalin alıcıda gözlendigi sistem anı
t − τsr sinyalin uydu anteninden çıktıgı sistem anı
Parametre Tanım
δtr(t) = tr − t alıcı saat hatası
δts(t − τsr) = ts − t uydu saat hatası
dτr(t) alıcı donanım gecikmesi
dτs(t − τsr) uydu donanım gecikmesi
Φsr(t) Ta¸sıyıcı dalga faz farkı (tamsayı bilinmeyeni dahil)
Nsr Ba¸slangıç tamsayı faz bilinmeyeni
dIsr(t) sinyal yolu iyonosfer gecikmesi
dTsr(t) sinyal yolu troposfer gecikmesi
dmsP,r(t), dmsΦ,r(t) sinyal yansıma (multipath) gecikmesi (kod ve faz)
esP,r(t), esΦ,r(t) rasgele gözlem hataları (kod ve faz)

