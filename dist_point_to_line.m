function d = dist_point_to_line(x,y,a,b)
%
%A is the point that we are looking for
%
%B is the coordinate in X
%
%C is the coordinate in Y

d=abs(x*a+y*b)/sqrt(a^2+b^2);

end


