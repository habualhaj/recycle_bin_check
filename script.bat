@echo off

::::::::: EDIT PATH HERE :::::::::::
C:\path\to\RBCmd.exe -q -d "C:\$Recycle.Bin" --csv %TEMP%\export --dt "yyyy-MM-dd" >nul
::::::::::::::::::::::::::::::::::::

set TEMP_PYTHON_FILE=%TEMP%\myscript.py
echo import os >> %TEMP_PYTHON_FILE%
echo import pandas as pd >> %TEMP_PYTHON_FILE%

::::::::: EDIT USER HERE :::::::::::
echo df = pd.read_csv(os.path.join(r'C:\Users\USER\AppData\Local\Temp\export', os.listdir(r'C:\Users\USER\AppData\Local\Temp\export')[0])) >> %TEMP_PYTHON_FILE%
::::::::::::::::::::::::::::::::::::

echo print(f"Oldest File: [{df['DeletedOn'].sort_values().values.tolist()[0]}]") >> %TEMP_PYTHON_FILE%
echo total_size = df['FileSize'].sum() >> %TEMP_PYTHON_FILE%
echo if total_size ^< 1024: >> %TEMP_PYTHON_FILE%
echo     print(f"{total_size} B") >> %TEMP_PYTHON_FILE%
echo elif total_size ^< 1024**2: >> %TEMP_PYTHON_FILE%
echo     print(f"{total_size/1024:.2f} KB") >> %TEMP_PYTHON_FILE%
echo elif total_size ^< 1024**3: >> %TEMP_PYTHON_FILE%
echo     print(f"{total_size/1024**2:.2f} MB") >> %TEMP_PYTHON_FILE%
echo elif total_size ^< 1024**4: >> %TEMP_PYTHON_FILE%
echo     print(f"{total_size/1024**3:.2f} GB") >> %TEMP_PYTHON_FILE%
echo else: >> %TEMP_PYTHON_FILE%
echo     print(f"{total_size/1024**4:.2f} TB") >> %TEMP_PYTHON_FILE%
python %TEMP_PYTHON_FILE%
del %TEMP_PYTHON_FILE%
rmdir /s /q %TEMP%\export
pause
