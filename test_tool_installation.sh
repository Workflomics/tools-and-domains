#!/bin/sh
  
  
  conda run --no-capture-output -n flashlfq FlashLFQ --version
   if [ $? -eq 0 ]; then
      echo "flashlfq test passed."
    else
      echo "flashlfq test failed."
   fi

   conda run --no-capture-output -n comet-ms comet --version
   if [ $? -eq 0 ]; then
      echo "comet test passed."
    else
      echo "comet test failed."
   fi

   conda run --no-capture-output -n maxquant maxquant --version
   if [ $? -eq 0 ]; then
      echo "maxquant test passed."
    else
      echo "maxquant test failed."
   fi

   conda run --no-capture-output -n mergeoutput R --version
   if [ $? -eq 0 ]; then
      echo "mergeoutput test passed."
    else
      echo "mergeoutput test failed."
   fi

   conda run --no-capture-output -n bioconductor-normalyzerde R --version
   if [ $? -eq 0 ]; then
      echo "normalyzerde test passed."
    else
      echo "normalyzerde test failed."
   fi

   conda run --no-capture-output -n polystest R --version
   if [ $? -eq 0 ]; then
      echo "polystest test passed."
    else
      echo "polystest test failed."
   fi

   conda run --no-capture-output -n protxml2csv R --version
   if [ $? -eq 0 ]; then
      echo "protxml2csv test passed."
    else
      echo "protxml2csv test failed."
   fi

   conda run --no-capture-output -n raw2mzml thermorawfileparser --version
   if [ $? -eq 0 ]; then
      echo "raw2mzml test passed."
    else
      echo "raw2mzml test failed."
   fi

   conda run --no-capture-output -n rots R --version
   if [ $? -eq 0 ]; then
      echo "rots test passed."
    else
      echo "rots test failed."
   fi

   conda run --no-capture-output -n searchgui searchgui --version
   if [ $? -eq 0 ]; then
      echo "searchgui test passed."
    else
      echo "searchgui test failed."
   fi

   conda run --no-capture-output -n tpp StPeter --version
   if [ $? -eq 0 ]; then
      echo "StPeter test passed."
    else
      echo "StPeter test failed."
   fi

   conda run --no-capture-output -n tpp  xinteract --version
   if [ $? -eq 0 ]; then
      echo "xinteract test passed."
    else
      echo "xinteract test failed."
   fi

   conda run --no-capture-output -n tpp  ProteinProphet --version
   if [ $? -eq 0 ]; then
      echo "ProteinProphet test passed."
    else
      echo "ProteinProphet test failed."
   fi