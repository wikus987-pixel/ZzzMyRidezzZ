Get-ChildItem -Path 'C:\Users\Wikus\.openclaw\workspace\lib' -Recurse -Filter *.dart |
  Where-Object { $_.Name -match 'payment|paypal' } |
  Select-Object -ExpandProperty FullName