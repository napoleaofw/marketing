set "comma=,"
set "begin=var placeList = ["
set "end=];"

echo|set /p=%begin%>"placeList.js"

echo.>>"placeList.js"
for %%f in ("0*.js") do (
  findstr /c:results %%f>>"placeList.js"
  echo %comma%>>"placeList.js"
)
echo|set /p=%end%>>"placeList.js"

pause