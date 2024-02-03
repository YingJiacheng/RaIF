function [Sky_Map, Veg_Map] = GenerateRegionMaps(I_RGB,I_NIR)

Sky_Map = GenerateSkyMap(I_RGB,I_NIR);

Veg_Map = GenerateVegMap(I_RGB,I_NIR,Sky_Map);


end
