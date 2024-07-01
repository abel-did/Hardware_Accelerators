figure(1);
subplot(2, 2, 1);
plot(NbrDeBit, Tmin), xlabel('Number of bits'), ylabel('T_{min}(ns)'), title('T_{min} (ns) = 100 ns – WNS (ns)')
subplot(2, 2, 2);
plot(NbrDeBit, Fmax), xlabel('Number of bits'), ylabel('Fmax'), title('f_{max} (Hz) = 1/T_{min}(ns)')
subplot(2, 2, 3);
plot(NbrDeBit,Slice,NbrDeBit,SliceTheorique,NbrDeBit,DifferenceSlice), xlabel('Number of bits'), ylabel('Slice'), title('f(N\_bit) = Number of Slice')
subplot(2, 2, 4);
plot(NbrDeBit, LUTAsLogic,NbrDeBit,LUTTheorique,NbrDeBit,DiffLUT), xlabel('Number of bits'), ylabel('LUT'), title('f(N\_bit) = Number of LUT')

