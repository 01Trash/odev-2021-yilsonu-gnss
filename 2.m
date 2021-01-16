clear; close all; clc;

%%% IGS BROADCAST EPHEMERIS FILE verileri

% t sinyalin alıcıda gözlendiği sistem anı
% t - Tsr sinyalin uydu anteninden çıktıgı sistem anı

% Parametre              =>       Tanım
% δtr(t) = tr - t        =>  alıcı saat hatası
% δts(t - Tsr) = ts - t  =>  uydu saat hatası
% dTr(t)                 =>  alıcı donanım gecikmesi
% dTs(t - Tsr)           =>  uydu donanım gecikmesi
% Φsr(t)                 =>  Taşıyıcı dalga faz farkı (tamsayı bilinmeyeni dahil)
% Nsr                    =>  Başlangıç tamsayı faz bilinmeyeni
% dIsr(t)                =>  sinyal yolu iyonosfer gecikmesi
% dTsr(t)                =>  sinyal yolu troposfer gecikmesi
% dmsP, r(t), dmsΦ, r(t) =>  sinyal yansıma (multipath) gecikmesi (kod ve faz)
% esP, r(t), esΦ, r(t)   =>  rasgele gözlem hataları (kod ve faz)

