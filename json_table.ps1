#Get-Content C:\Users\eddylsk\Downloads\JSON\Sample.json | ConvertFrom-Json | ConvertTo-Csv | Out-File C:\Users\eddylsk\Downloads\JSON\TableOutput.csv

#$PSVersionTable.PSVersion

Get-Content C:\Users\eddylsk\Downloads\JSON\Sample.json

Get-Content C:\Users\eddylsk\Downloads\JSON\Sample.json | ConvertFrom-Json | Export-Csv -Path C:\Users\eddylsk\Downloads\JSON\TableOutput.csv

#$properties=@('id','type','name','ppu', 'batters', 'topping')
#(Get-Content 'C:\Users\eddylsk\Downloads\JSON\json_test1.json' -Raw | ConvertFrom-Json)| Select-Object -Property $properties | Export-CSV -NoTypeInformation -Path 'C:\Users\eddylsk\Downloads\JSON\TableOutput.csv'

#$properties=@('id','type','name','ppu', 'batters', 'topping')
#(Get-Content 'C:\Users\eddylsk\Downloads\JSON\Sample.json' -Raw | ConvertFrom-Json)| Select-Object -Property $properties | Export-CSV -NoTypeInformation -Path 'C:\Users\eddylsk\Downloads\JSON\TableOutput.csv'

# helper to turn PSCustomObject into a list of key/value pairs
$filepath = "C:\Users\eddylsk\Downloads\JSON\TableOutput.csv";

function Get-ObjectMember {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True, ValueFromPipeline=$True)]
        [PSCustomObject]$obj
    )
    $obj | Get-Member -MemberType NoteProperty | ForEach-Object {
        $key = $_.Name
        [PSCustomObject]@{Key = $key; Value = $obj."$key"}
    }
}


#$json = '{"17443": {"17444": {"sid": "17444","nid": "7728","submitted": "1436891400","data": {"3": {"value": ["Miss"]},"4": {"value": ["Charlotte"]},"5": {"value": ["Tann"]}}},"17445": {"sid": "17445","nid": "7728","submitted": "1437142325","data": {"3": {"value": ["Mr"]},"4": {"value": ["John"]},"5": {"value": ["Brokland"]}}},"sid": "17443","nid": "7728","submitted": "1436175407","data": {"3": {"value": ["Mr"]},"4": {"value": ["Jack"]},"5": {"value": ["Cawles"]}}}}'

#$json = '{"items":{"item":[{"id":"0001","type":"Donut","name":"Cake","ppu":0.55,"batters":{"batter":[{"id":"1001","type":"Regular"},{"id":"1002","type":"Chocolate"},{"id":"1003","type":"Blueberry"},{"id":"1004","type":"Devil\"s Food"}]},"topping":[{"id":"5001","type":"None"},{"id":"5002","type":"Glazed"},{"id":"5005","type":"Sugar"},{"id":"5007","type":"Powdered Sugar"},{"id":"5006","type":"Chocolate with Sprinkles"},{"id":"5003","type":"Chocolate"},{"id":"5004","type":"Maple"}]},{"id":"0002","type":"Molten Cake","name":"Lava Cake","ppu":0.70,"batters":{"batter":[{"id":"1002","type":"Chocolate"},{"id":"1003","type":"White Choco."},{"id":"1004","type":"Devil\"s Food"}]},"topping":[{"id":"5001","type":"None"},{"id":"5002","type":"Glazed"},{"id":"5005","type":"Sugar"},{"id":"5007","type":"Powdered Sugar"},{"id":"5006","type":"Chocolate with Sprinkles"},{"id":"5003","type":"Chocolate"},{"id":"5004","type":"Maple"},{"id":"5008","type":"Caramel"}]}]}}'

$json = Get-Content C:\Users\eddylsk\Downloads\JSON\Sample.json;
$objects = $json | ConvertFrom-Json | Get-ObjectMember | foreach {
    $_.Value | Get-ObjectMember | foreach { 
           [PSCustomObject]@{
                id = $_.value.id
                type = $_.Value.type
                name = $_.Value.name
                ppu = $_.Value.ppu
                batterId = $_.Value.batters."batter".id
                batterType = $_.Value.batters."batter".type
                toppingId = $_.Value.topping.id
                toppingValue = $_.Value.topping.type
            }
        }
    }

$objects | ConvertTo-Csv > $filepath;
<#
$rawJSONPath = "C:\Users\eddylsk\Downloads\JSON\Sample.json";
$objects = Get-Content -Path $rawJSONPath -Raw | ConvertFrom-Json;
Write-Host $objects;

$objects | ForEach-Object { 
             $objectsList += Select-Object -Property id, type, name, ppu, @{Name = 'batters'; Expression = { $_.batter.id, $_.batter.type}}, @{Name = 'topping'; Expression = { $_.Value.id, $_.Value.type}};
             #Write-Host "Add new line...";
			$objectsList += "`n$_";
        }

Write-Host $objectsList;
$objectsList | Export-Csv $filepath -NoTypeInformation;
$objectsList | Format-Table -AutoSize;
#>

<#
$rawJSONPath = "C:\Users\eddylsk\Downloads\JSON\Sample.json";
$objects = Get-Content -Path $rawJSONPath -Raw | ConvertFrom-Json;
$objects | foreach {
        $objectsList += select id, type, name, ppu, @{Name = 'batters'; Expression = { $_.batter.id, $_.batter.type}}, @{Name = 'topping'; Expression = { $_.Value.id, $_.Value.type}};
        $objectsList += "`n$_";
    }
Write-Host $objectsList;

$objectsList = $objects | foreach {

    $id = $_.id;

    $_.members | foreach {
        [pscustomobject]@{
            squadName = $squadName
            name = $_.name
            age = $_.age
            secretIdentity = $_.secretIdentity
        }
    }   
}
$objectsList | ConvertTo-Csv > $filepath;
#>

<#

$members = $obj | foreach {

    $squadName = $_.squadName

    $_.members | foreach {
        [pscustomobject]@{
            squadName = $squadName
            name = $_.name
            age = $_.age
            secretIdentity = $_.secretIdentity
        }
    }   
}
$members | ConvertTo-Csv > c:\members.csv

#>



# helper to turn PSCustomObject into a list of key/value pairs
function Get-ObjectMember {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True, ValueFromPipeline=$True)]
        [PSCustomObject]$obj
    )
    $obj | Get-Member -MemberType NoteProperty | ForEach-Object {
        $key = $_.Name
        [PSCustomObject]@{Key = $key; Value = $obj."$key"}
    }
}

$json = '{"17443": {"17444": {"sid": "17444","nid": "7728","submitted": "1436891400","data": {"3": {"value": ["Miss"]},"4": {"value": ["Charlotte"]},"5": {"value": ["Tann"]}}},"17445": {"sid": "17445","nid": "7728","submitted": "1437142325","data": {"3": {"value": ["Mr"]},"4": {"value": ["John"]},"5": {"value": ["Brokland"]}}},"sid": "17443","nid": "7728","submitted": "1436175407","data": {"3": {"value": ["Mr"]},"4": {"value": ["Jack"]},"5": {"value": ["Cawles"]}}}}'

$json | ConvertFrom-Json | Get-ObjectMember | foreach {
    $_.Value | Get-ObjectMember | where Key -match "^\d+$" | foreach {
        [PSCustomObject]@{
            Title = $_.value.data."3".value | select -First 1
            FirstName = $_.Value.data."4".value | select -First 1
            LastName = $_.Value.data."5".value | select -First 1
        }
    }
}


$rawJSONPath = "C:\Users\eddylsk\Downloads\JSON\Sample.json";
$filepath = "C:\Users\eddylsk\Downloads\JSON\TableOutput.csv";

Get-Content $rawJSONPath |
    ConvertFrom-Json | 
    Select -Expand items |
    Select -Expand item |
    Select -Expand batters |
    ForEach {
       $_.id = $_.id -join ' '
       $_
    };
    
 Export-Csv $filepath -NoTypeInformation

$rawJSONPath = "C:\Users\eddylsk\Downloads\JSON\Sample.json";
$filepath = "C:\Users\eddylsk\Downloads\JSON\TableOutput.csv";
$batterList = Get-Content $rawJSONPath |
    ConvertFrom-Json | 
    Select -Expand items |
    Select -Expand item |
    Select -Expand batters |
    Select -Expand batter |
    ForEach {
       $_.id = $_.id -join ' '
       $_
    };

Write-Host $batterList;

$rawJSONPath = "C:\Users\eddylsk\Downloads\JSON\Sample.json";
$filepath = "C:\Users\eddylsk\Downloads\JSON\TableOutput.csv";
$toppingList = Get-Content $rawJSONPath |
    ConvertFrom-Json | 
    Select -Expand items |
    Select -Expand item |
    Select -Expand topping |
    ForEach {
       $_.id = $_.id -join ' '
       $_
    };
 Write-Host $toppingList;

$rawJSONPath = "C:\Users\eddylsk\Downloads\JSON\Sample.json";
$filepath = "C:\Users\eddylsk\Downloads\JSON\TableOutput.csv";



<#
$rawJSONPath = "C:\Users\eddylsk\Downloads\JSON\Sample.json";
$filepath = "C:\Users\eddylsk\Downloads\JSON\TableOutput.csv";
$json = Get-Content $rawJSONPath -Raw | ConvertFrom-Json
$all = @( ($json.items | Select-Object *, @{Name = 'batters'; Expression = { 'batter' } }) ) + ($json.items | Select-Object *, @{Name = 'topping'; Expression = { 'topping' } })
$properties = ($all | ForEach-Object { $_ | Get-Member -MemberType NoteProperty}) | Select-Object -Unique -ExpandProperty Name
$destinationFilePath = $filepath
$all | Select-Object -Property $properties | Export-Csv -NoTypeInformation -Path $destinationFilePath
#>

<#
Get-Content r:\1.json -Raw |
    ConvertFrom-Json | 
    Select -Expand data |
    Select -Expand stations |
    ForEach {
        $_.rental_methods = $_.rental_methods -join ' '
        $_
    } |
    Export-Csv r:\1.csv -NoTypeInformation
#>