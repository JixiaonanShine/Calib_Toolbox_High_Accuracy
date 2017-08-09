% function [ Image3D ] = reprojectImageTo3D(disparity,  Qmat, handleMissingValues, dtype)
% [cols,rows] = size(disparity);
% minDisparity = min(min(disparity));
% 
% 
% end

function XYZ = reprojectImageTo3D(D, Q)
    [h,w] = size(D);
    XYZ = zeros([h,w,3]);
    for x=1:h
        for y=1:w
            v = Q * [x; y; double(D(x,y)); 1];
            v = v(1:3) ./ v(4);
            XYZ(x,y,:) = v;
        end
    end
end