SELECT * FROM 
[RepPOSQ002 (Z Reading - Current - Sales)] 
UNION SELECT * FROM [RepPOSQ004 (Z Reading - Current - Collection)] 
UNION SELECT * FROM [RepPOSQ006 (Z Reading - Previous - Sales)] 
UNION SELECT * FROM [RepPOSQ008 (Z Reading - Current - Sales Return)];