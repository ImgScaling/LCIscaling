%Read Image

I_in=imread('img_example.bmp');

%Call LCI with scale factor as input
% Scale=1/2;
% I_out=LCI(I_in,Scale);

%Call LCI with size (m_ouy,n_out)
m_out=796;
n_out=1024;
I_out=LCI(I_in,m_out,n_out);

% Save image 
imwrite(I_out,'img_resized.bmp','bmp');