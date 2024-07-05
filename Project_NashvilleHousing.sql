
/*

Cleaning Data in SQL Queries

*/


select *
from ProjectHousing.dbo.NashvilleHousing

--------------------------------------------------------------------------------------------------------------------------

-- Standardize Date Format

select SaleDate, SaleDateConverted
from NashvilleHousing

alter table NashvilleHousing
Add SaleDateConverted date;

UPDATE NashvilleHousing
SET SaleDateConverted = Convert(Date, SaleDate)



 --------------------------------------------------------------------------------------------------------------------------

-- Populate Property Address data

select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress
from NashvilleHousing as a
join NashvilleHousing as b
on a.ParcelID = b.ParcelID 
AND a.UniqueID <> b.UniqueID
where a.PropertyAddress is null

update a
set a.PropertyAddress = isnull(a.PropertyAddress, b.PropertyAddress)
from NashvilleHousing as a
join NashvilleHousing as b
on a.ParcelID = b.ParcelID 
AND a.UniqueID <> b.UniqueID
where a.PropertyAddress is null


--------------------------------------------------------------------------------------------------------------------------

-- Breaking out Address into Individual Columns (Address, City, State)

SELECT 
	SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1) as SplitAddress,
	SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress)) as SplitCity

FROM [ProjectHousing].[dbo].[NashvilleHousing]


alter table [ProjectHousing].[dbo].[NashvilleHousing]
Add PropertySplitAddress nvarchar(255);

UPDATE [ProjectHousing].[dbo].[NashvilleHousing]
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1)


alter table [ProjectHousing].[dbo].[NashvilleHousing]
Add PropertySplitState nvarchar(255);

UPDATE [ProjectHousing].[dbo].[NashvilleHousing]
SET PropertySplitState = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress))



select 
	PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
	PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
	PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
from NashvilleHousing


alter table [ProjectHousing].[dbo].[NashvilleHousing]
Add 
	OwnerSplitAddress nvarchar(255),
	OwnerSplitCity nvarchar(255),
	OwnerSplitState nvarchar(255);

UPDATE [ProjectHousing].[dbo].[NashvilleHousing]
SET 
	OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
	OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
	OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)



--------------------------------------------------------------------------------------------------------------------------


-- Change 1 and 0 to Yes and No in "Sold as Vacant" field

select distinct SoldAsVacant, count(SoldAsVacant)
from NashvilleHousing
group by SoldAsVacant
order by 2


alter table NashvilleHousing
alter column SoldAsVacant nvarchar(50);

select SoldAsVacant,
	case
	when SoldAsVacant = 1 then 'Yes'
	when SoldAsVacant = 0 then 'No'
	else SoldAsVacant
	end
from NashvilleHousing

update NashvilleHousing
set SoldAsVacant = case
	when SoldAsVacant = 1 then 'Yes'
	when SoldAsVacant = 0 then 'No'
	else SoldAsVacant
	end


-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- Remove Duplicates

with rownumCTE as 
(
	select *, 
		ROW_NUMBER() over 
		(partition by 
			ParcelID,
			PropertyAddress,
			SalePrice,
			SaleDate,
			LegalReference
		Order by
			UniqueID) as rownum
	from NashvilleHousing
)

select *
from rownumCTE
where rownum > 1


---------------------------------------------------------------------------------------------------------

-- Delete Unused Columns

select *
from NashvilleHousing

alter table NashvilleHousing
drop column 
	SplitAddress,
	PropertyAddress,
	SaleDate,
	OwnerAddress



















