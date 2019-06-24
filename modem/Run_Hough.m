load wfh;
% load wfn;

subplot(1, 2, 1);
box = Normalise(wfh);
box_edge = edge(box, 'canny');
[H,T,R] = hough(box_edge,'RhoResolution',0.5,'Theta',-90:0.5:89);
imshow(imadjust(rescale(H)),'XData',T,'YData',R, 'InitialMagnification','fit');

subplot(1, 2, 2);
box = Normalise(wfn);
box_edge = edge(box, 'canny');
[H,T,R] = hough(box_edge,'RhoResolution',0.5,'Theta',-90:0.5:89);
imshow(imadjust(rescale(H)),'XData',T,'YData',R, 'InitialMagnification','fit');