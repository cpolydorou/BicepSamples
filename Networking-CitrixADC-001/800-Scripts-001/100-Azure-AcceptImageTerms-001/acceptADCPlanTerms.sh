# Use Azure CLI to accept the terms for using the Citrix ADC plan

az vm image terms accept --publisher citrix \
                         --offer netscalervpx-131 \
                         --plan netscalerbyol