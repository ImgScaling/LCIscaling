%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Lagrange-Chebyshev Interpolation (LCI) Matlab scripts                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUT
% I_in -> input image
% varargin -> scale factor or number of rows, number of columns 
% OUTPUT
% I_fin-> resized image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copyright (c) 2021, 
% Donatella Occorsio, Giuliana Ramella, Woula Themistoclakis
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this Software and associated documentation files, to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
% In case results obtained with the present software, or parts of it, are
% published in a scientific paper, the following reference should be cite:
%
% D. Occorsio, G. Ramella, W. Themistoclakis, "Lagrange-Chebyshev Interpolation 
% for image resizing", arXiv:2109.03779 (2021).
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function I_fin = LCI(I_in,varargin)

%Size computation
[n1,n2,c]=size(I_in);

switch nargin
        case 3
            mi=varargin{1};
            ni=varargin{2};
        case 2
            mi=varargin{1}*n1;
            ni=varargin{1}*n2;
        otherwise
            fprintf('Number of parameters not adequate\n');
end

%Image values transformation
I_in=double(I_in);

% eta and csi computation
eta=(2*(1: mi)-1)*pi/(2*mi); 
csi=(2*(1: ni)-1)*pi/(2*ni);

% Chebychev polynomials with IDCT weighs: T(k,i)=cos(k*s_i)*wk
T1=cos(([0:n1-1])'.*eta)*sqrt(2/n1);T1(1,:)=sqrt(1/n1);
T2=cos(([0:n2-1])'.*csi)*sqrt(2/n2);T2(1,:)=sqrt(1/n2);

% lx and ly computation
lx=idct(T1(1:n1,:)); ly=idct(T2(1:n2,:)); 

if (c==3)
    % RGB Image
    val1=(lx'*I_in(:,:,1))*ly; I_fin(:,:,1)=uint8(val1); % red component image
    val2=(lx'*I_in(:,:,2))*ly; I_fin(:,:,2)=uint8(val2); % green component image
    val3=(lx'*I_in(:,:,3))*ly; I_fin(:,:,3)=uint8(val3); % blue component image
else
    % Gray level image
    val=(lx'*I_in(:,:))*ly; I_fin(:,:)=uint8(val); 
end


