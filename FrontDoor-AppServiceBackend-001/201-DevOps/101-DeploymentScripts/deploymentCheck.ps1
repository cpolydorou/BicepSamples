####################################################################################
# Script : deploymentCheck.ps1
# Purpose: Check the status of the deployment by trying to access the app service
#          through Front Door.
####################################################################################

# Script Parameters
param (
    [string]$URL
)

# The number of seconds to wait in total
$totalSeconds = 20

# The intervale between tries
$interval = 10

# A counter for the seconds passed
$elapsed = 0;

# A variable to note whether the page is available
$provisioned = 0;

# Check the status of the service
while($elapsed -lt $totalSeconds)
{
    # Notify on the start of check
    Write-Host ("Checking the status of the service at " + $URL)

    # Check the service
    try
    {
        # Try to get the page
        $response = Invoke-WebRequest -Uri ("https://" + $URL) -ErrorAction stop

        # Check the headers
        if($response.StatusCode -eq 200)
        {
            # The page can be accessed through Front Door
            $provisioned++

            # Break the execution
            return
        }
    }
    catch
    {
        # The page is not yet available through Front Door
        Write-Host ("Exception thrown: " + $_.Exception.Message)
    }

    # Wait for the interval
    Write-Host ("Waiting for " + $interval.ToString() + " seconds.")
    Start-Sleep -seconds $interval

    # Increase the counter
    $elapsed += $interval
}

# Throw an exception if the service is not available
if($provisioned -eq 0)
{
    throw ("Service failed to provision after " + $elapsed.ToString() + " seconds")
}