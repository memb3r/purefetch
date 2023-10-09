#!/bin/bash

echo '#!/usr/bin/env python3' > purefetch.py
echo 'import os' >> purefetch.py
echo 'import platform' >> purefetch.py
echo 'import subprocess' >> purefetch.py
echo 'import psutil' >> purefetch.py
echo 'from colorama import init, Fore, Style' >> purefetch.py
echo '' >> purefetch.py
echo 'def run_command(command):' >> purefetch.py
echo '    try:' >> purefetch.py
echo '        result = subprocess.check_output(command, shell=True, stderr=subprocess.STDOUT, text=True)' >> purefetch.py
echo '        return result.strip()' >> purefetch.py
echo '    except subprocess.CalledProcessError as e:' >> purefetch.py
echo '        return str(e)' >> purefetch.py
echo '' >> purefetch.py
echo "user = os.getenv('USER')" >> purefetch.py
echo "host = platform.node()" >> purefetch.py
echo "os_info = platform.system()" >> purefetch.py
echo "kernel = platform.release()" >> purefetch.py
echo "uptime = run_command('uptime -s')" >> purefetch.py
echo "packages = run_command('dpkg -l | grep -c \"^ii\"')" >> purefetch.py
echo "cpu = run_command('lscpu | grep \"Model name\" | sed -e \"s/Model name://g\" | xargs')" >> purefetch.py
echo "memory_info = psutil.virtual_memory()" >> purefetch.py
echo "used_memory = memory_info.used" >> purefetch.py
echo "free_memory = memory_info.available" >> purefetch.py
echo '' >> purefetch.py
echo "init(autoreset=True)" >> purefetch.py
echo '' >> purefetch.py
echo "print(f'{Fore.LIGHTGREEN_EX}       /^-^\     {user}{Fore.WHITE}@{Fore.LIGHTGREEN_EX}{host}')" >> purefetch.py
echo "print(f'{Fore.LIGHTGREEN_EX}      /{Fore.WHITE} o o {Fore.LIGHTGREEN_EX}\ ')" >> purefetch.py
echo "print(f'{Fore.LIGHTGREEN_EX}     /{Fore.WHITE}   Y   {Fore.LIGHTGREEN_EX}\   os: {Fore.WHITE}{os_info}')" >> purefetch.py
echo "print(f'{Fore.LIGHTGREEN_EX}     V \ {Fore.WHITE}v{Fore.LIGHTGREEN_EX} / V   kernel: {Fore.WHITE}{kernel}')" >> purefetch.py
echo "print(f'{Fore.LIGHTGREEN_EX}       / - \     uptime: {Fore.WHITE}{uptime}')" >> purefetch.py
echo "print(f'{Fore.LIGHTGREEN_EX}      /    |     packages: {Fore.WHITE}{packages}')" >> purefetch.py
echo "print(f'{Fore.LIGHTGREEN_EX}(    /     |     cpu: {Fore.WHITE}{cpu}')" >> purefetch.py
echo "print(f'{Fore.LIGHTGREEN_EX} ===/___) ||     ram: {Fore.WHITE}{used_memory}/{free_memory}')" >> purefetch.py

pip install colorama
pip install psutil
touch purefetch
echo "#!/bin/bash" > purefetch
echo "python3 purefetch.py" >> purefetch
chmod +x purefetch

echo "Установка завершена. Чтобы запустить Purefetch, используйте команду ./purefetch"