function ass_value=my_ass(sig)
temp = sum(sig .^ (1/2));
ass_value  = abs(temp);
end