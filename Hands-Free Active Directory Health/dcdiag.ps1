function Invoke-DcDiag {
    param()
    $dcDiagOutput = dcdiag /s:DC

    ## Add the entity to our object
    $dcDiagOutput | select-string -pattern '\. (.*) \b(passed|failed)\b test (.*)' | foreach { 
        $futureObject = @{
            TestName = $_.Matches.Groups[3].Value
            TestResult = $_.Matches.Groups[2].Value 
            Entity = $_.Matches.Groups[1].Value 
        }
        [pscustomobject]$futureObject
    }
}