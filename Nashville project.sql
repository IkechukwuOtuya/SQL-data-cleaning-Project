--Data cleaning project

SELECT*
  FROM [Nashville project].[dbo].[Nashville Housing Data for Data Cleaning CSV]
 
  
SELECT CONVERT(DATE,SaleDate)
  FROM [Nashville project].[dbo].[Nashville Housing Data for Data Cleaning CSV]

  UPDATE [Nashville project].[dbo].[Nashville Housing Data for Data Cleaning CSV]
  SET SaleDate = CONVERT(DATE,SaleDate)

  --- populate empty cells


  UPDATE [Nashville project].[dbo].[Nashville Housing Data for Data Cleaning CSV]
SET PropertyAddress = CASE WHEN PropertyAddress = '' THEN NULL ELSE PropertyAddress END

  
SELECT Nash.parcelID, Nash.PropertyAddress, ville.parcelID, ville.PropertyAddress,
  ISNULL(NASH.Propertyaddress, ville.PropertyAddress)
  FROM [Nashville project].[dbo].[Nashville Housing Data for Data Cleaning CSV] Nash
  JOIN  [Nashville project].[dbo].[Nashville Housing Data for Data Cleaning CSV] ville
  ON Nash.ParcelID = ville.ParcelID and Nash.[UniqueID ] <> ville.[UniqueID ]
  WHERE Nash.PropertyAddress is null


UPDATE Nash
SET Nash.PropertyAddress = ISNULL(Nash.PropertyAddress, ville.PropertyAddress)
FROM [Nashville project].[dbo].[Nashville Housing Data for Data Cleaning CSV] Nash
JOIN [Nashville project].[dbo].[Nashville Housing Data for Data Cleaning CSV] ville
    ON Nash.ParcelID = ville.ParcelID AND Nash.[UniqueID ] <> ville.[UniqueID ]
WHERE Nash.PropertyAddress IS NULL;


--- slitting column using delimiter 

SELECT
	PARSENAME(REPLACE(PropertyAddress,',', '.') , 2),
	PARSENAME(REPLACE(PropertyAddress,',', '.') , 1)
  FROM [Nashville project].[dbo].[Nashville Housing Data for Data Cleaning CSV]
 



 ALTER TABLE [Nashville Housing Data for Data Cleaning CSV]
 ADD PropertySpiltAddress NVARCHAR(255)

 UPDATE [Nashville project].dbo.[Nashville Housing Data for Data Cleaning CSV]
	SET PropertySpiltAddress = PARSENAME(REPLACE(PropertyAddress,',', '.') , 2)



	 ALTER TABLE [Nashville Housing Data for Data Cleaning CSV]
 ADD PropertySpiltCity NVARCHAR(255)

	 UPDATE [Nashville project].dbo.[Nashville Housing Data for Data Cleaning CSV]
	SET PropertySpiltCity = PARSENAME(replace(PropertyAddress,',', '.') , 1)


	
SELECT
	PARSENAME(replace(OwnerAddress,',', '.') , 3),
	PARSENAME(replace(OwnerAddress,',', '.') , 2),
	PARSENAME(replace(OwnerAddress,',', '.') , 1)
FROM [Nashville project].[dbo].[Nashville Housing Data for Data Cleaning CSV]
 
 	 ALTER TABLE [Nashville Housing Data for Data Cleaning CSV]
 ADD OwnerSpiltAddress NVARCHAR(255)

 UPDATE [Nashville project].[dbo].[Nashville Housing Data for Data Cleaning CSV]
	SET OwnerSpiltAddress = PARSENAME(REPLACE(OwnerAddress,',', '.') , 3)

		 ALTER TABLE [Nashville Housing Data for Data Cleaning CSV]
 ADD OwnerCityAddress NVARCHAR(255)

		 UPDATE [Nashville project].[dbo].[Nashville Housing Data for Data Cleaning CSV]
	set OwnerCityAddress = PARSENAME(REPLACE(OwnerAddress,',', '.') , 2)

		 ALTER TABLE [Nashville Housing Data for Data Cleaning CSV]
 Add OwnerStateAddress nvarchar(255)

		 UPDATE [Nashville project].[dbo].[Nashville Housing Data for Data Cleaning CSV]
	set OwnerStateAddress = PARSENAME(REPLACE(OwnerAddress,',', '.') , 1)




	---Change Y to YES and N to NO in sold as vacant

SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM [Nashville project].[dbo].[Nashville Housing Data for Data Cleaning CSV]
GROUP BY SoldAsVacant

 


	
SELECT SoldAsVacant,
CASE
	WHEN SoldAsVacant = 'N' Then 'No'
	WHEN SoldAsVacant = 'Y' Then 'Yes'
	ELSE SoldAsVacant
END
  FROM [Nashville project].[dbo].[Nashville Housing Data for Data Cleaning CSV]
 
  
UPDATE [Nashville project].[dbo].[Nashville Housing Data for Data Cleaning CSV]
SET SoldAsVacant = CASE
	WHEN SoldAsVacant = 'N' THEN 'No'
	WHEN SoldAsVacant = 'Y' THEN 'Yes'
	ELSE SoldAsVacant
END
 


  ---Delect unwanted columns

  SELECT*
  FROM [Nashville project].[dbo].[Nashville Housing Data for Data Cleaning CSV]
 

 ALTER TABLE [Nashville project].[dbo].[Nashville Housing Data for Data Cleaning CSV]
 DROP COLUMN PropertyAddress, OwnerAddress, TaxDistrict