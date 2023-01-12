# Kali - Hashcat - 3080ti/2080ti - Benchmark
<br>
## Benchmark taken 20230112
<br>
<hr>
<br>

```
CUDA API (CUDA 11.6)
====================
* Device #1: NVIDIA GeForce RTX 3080 Ti, 11782/12053 MB, 80MCU
* Device #2: NVIDIA GeForce RTX 2080 Ti, 10859/11019 MB, 68MCU

OpenCL API (OpenCL 3.0 CUDA 11.6.134) - Platform #1 [NVIDIA Corporation]
========================================================================
* Device #3: NVIDIA GeForce RTX 3080 Ti, skipped
* Device #4: NVIDIA GeForce RTX 2080 Ti, skipped

OpenCL API (OpenCL 3.0 PoCL 3.0+debian  Linux, None+Asserts, RELOC, LLVM 14.0.6, SLEEF, DISTRO, POCL_DEBUG) - Platform #2 [The pocl project]
============================================================================================================================================
* Device #5: pthread-AMD Ryzen Threadripper 3960X 24-Core Processor, skipped

Benchmark relevant options:
===========================
* --optimized-kernel-enable

-------------------
* Hash-Mode 0 (MD5)
-------------------

Speed.#1.........: 67747.4 MH/s (38.76ms) @ Accel:1024 Loops:1024 Thr:32 Vec:8
Speed.#2.........: 55515.0 MH/s (39.94ms) @ Accel:256 Loops:1024 Thr:128 Vec:8
Speed.#*.........:   123.3 GH/s

----------------------
* Hash-Mode 100 (SHA1)
----------------------

Speed.#1.........: 21343.0 MH/s (61.95ms) @ Accel:64 Loops:512 Thr:512 Vec:1
Speed.#2.........: 17698.0 MH/s (63.12ms) @ Accel:1024 Loops:512 Thr:32 Vec:1
Speed.#*.........: 39041.1 MH/s

---------------------------
* Hash-Mode 1400 (SHA2-256)
---------------------------

Speed.#1.........:  9218.3 MH/s (72.05ms) @ Accel:16 Loops:1024 Thr:512 Vec:1
Speed.#2.........:  7591.9 MH/s (74.20ms) @ Accel:16 Loops:1024 Thr:512 Vec:1
Speed.#*.........: 16810.3 MH/s

---------------------------
* Hash-Mode 1700 (SHA2-512)
---------------------------

Speed.#1.........:  3059.2 MH/s (54.05ms) @ Accel:4 Loops:1024 Thr:512 Vec:1
Speed.#2.........:  2511.6 MH/s (55.97ms) @ Accel:8 Loops:1024 Thr:256 Vec:1
Speed.#*.........:  5570.7 MH/s

-------------------------------------------------------------
* Hash-Mode 22000 (WPA-PBKDF2-PMKID+EAPOL) [Iterations: 4095]
-------------------------------------------------------------

Speed.#1.........:  1074.1 kH/s (75.02ms) @ Accel:8 Loops:1024 Thr:512 Vec:1
Speed.#2.........:   865.9 kH/s (77.34ms) @ Accel:16 Loops:1024 Thr:256 Vec:1
Speed.#*.........:  1940.0 kH/s

-----------------------
* Hash-Mode 1000 (NTLM)
-----------------------

Speed.#1.........:   117.2 GH/s (22.02ms) @ Accel:512 Loops:1024 Thr:64 Vec:8
Speed.#2.........: 98129.6 MH/s (21.93ms) @ Accel:1024 Loops:1024 Thr:32 Vec:8
Speed.#*.........:   215.3 GH/s

---------------------
* Hash-Mode 3000 (LM)
---------------------

Speed.#1.........: 62579.8 MH/s (20.71ms) @ Accel:64 Loops:1024 Thr:256 Vec:1
Speed.#2.........: 50400.9 MH/s (21.76ms) @ Accel:128 Loops:1024 Thr:128 Vec:1
Speed.#*.........:   113.0 GH/s

--------------------------------------------
* Hash-Mode 5500 (NetNTLMv1 / NetNTLMv1+ESS)
--------------------------------------------

Speed.#1.........: 66022.4 MH/s (80.09ms) @ Accel:128 Loops:1024 Thr:512 Vec:2
Speed.#2.........: 53800.5 MH/s (82.39ms) @ Accel:1024 Loops:1024 Thr:64 Vec:2
Speed.#*.........:   119.8 GH/s

----------------------------
* Hash-Mode 5600 (NetNTLMv2)
----------------------------

Speed.#1.........:  4739.0 MH/s (70.04ms) @ Accel:16 Loops:1024 Thr:256 Vec:1
Speed.#2.........:  3928.0 MH/s (71.66ms) @ Accel:32 Loops:512 Thr:256 Vec:1
Speed.#*.........:  8667.0 MH/s

--------------------------------------------------------
* Hash-Mode 1500 (descrypt, DES (Unix), Traditional DES)
--------------------------------------------------------

Speed.#1.........:  2591.6 MH/s (63.93ms) @ Accel:8 Loops:1024 Thr:256 Vec:1
Speed.#2.........:  2042.9 MH/s (68.95ms) @ Accel:16 Loops:1024 Thr:128 Vec:1
Speed.#*.........:  4634.5 MH/s

------------------------------------------------------------------------------
* Hash-Mode 500 (md5crypt, MD5 (Unix), Cisco-IOS $1$ (MD5)) [Iterations: 1000]
------------------------------------------------------------------------------

Speed.#1.........: 26749.2 kH/s (84.22ms) @ Accel:64 Loops:1000 Thr:512 Vec:1
Speed.#2.........: 17277.7 kH/s (87.72ms) @ Accel:64 Loops:500 Thr:1024 Vec:1
Speed.#*.........: 44026.9 kH/s

----------------------------------------------------------------
* Hash-Mode 3200 (bcrypt $2*$, Blowfish (Unix)) [Iterations: 32]
----------------------------------------------------------------

Speed.#1.........:    90738 H/s (70.90ms) @ Accel:4 Loops:32 Thr:24 Vec:1
Speed.#2.........:    61694 H/s (66.91ms) @ Accel:4 Loops:32 Thr:16 Vec:1
Speed.#*.........:   152.4 kH/s

--------------------------------------------------------------------
* Hash-Mode 1800 (sha512crypt $6$, SHA512 (Unix)) [Iterations: 5000]
--------------------------------------------------------------------

Speed.#1.........:   441.8 kH/s (58.29ms) @ Accel:1024 Loops:1024 Thr:128 Vec:1
Speed.#2.........:   279.3 kH/s (45.93ms) @ Accel:4096 Loops:512 Thr:32 Vec:1
Speed.#*.........:   721.0 kH/s

--------------------------------------------------------
* Hash-Mode 7500 (Kerberos 5, etype 23, AS-REQ Pre-Auth)
--------------------------------------------------------

Speed.#1.........:  1481.8 MH/s (55.81ms) @ Accel:256 Loops:128 Thr:32 Vec:1
Speed.#2.........:  1006.8 MH/s (70.07ms) @ Accel:64 Loops:512 Thr:32 Vec:1
Speed.#*.........:  2488.6 MH/s

-------------------------------------------------
* Hash-Mode 13100 (Kerberos 5, etype 23, TGS-REP)
-------------------------------------------------

Speed.#1.........:  1455.8 MH/s (56.86ms) @ Accel:256 Loops:128 Thr:32 Vec:1
Speed.#2.........:   973.7 MH/s (72.28ms) @ Accel:256 Loops:128 Thr:32 Vec:1
Speed.#*.........:  2429.4 MH/s

---------------------------------------------------------------------------------
* Hash-Mode 15300 (DPAPI masterkey file v1 (context 1 and 2)) [Iterations: 23999]
---------------------------------------------------------------------------------

Speed.#1.........:   184.8 kH/s (74.52ms) @ Accel:16 Loops:512 Thr:512 Vec:1
Speed.#2.........:   152.7 kH/s (74.78ms) @ Accel:8 Loops:1024 Thr:512 Vec:1
Speed.#*.........:   337.5 kH/s

---------------------------------------------------------------------------------
* Hash-Mode 15900 (DPAPI masterkey file v2 (context 1 and 2)) [Iterations: 12899]
---------------------------------------------------------------------------------

Speed.#1.........:   104.3 kH/s (59.55ms) @ Accel:2 Loops:1024 Thr:512 Vec:1
Speed.#2.........:    85736 H/s (62.63ms) @ Accel:16 Loops:256 Thr:256 Vec:1
Speed.#*.........:   190.0 kH/s

------------------------------------------------------------------
* Hash-Mode 7100 (macOS v10.8+ (PBKDF2-SHA512)) [Iterations: 1023]
------------------------------------------------------------------

Speed.#1.........:  1282.1 kH/s (49.87ms) @ Accel:8 Loops:255 Thr:512 Vec:1
Speed.#2.........:  1020.3 kH/s (51.36ms) @ Accel:16 Loops:255 Thr:256 Vec:1
Speed.#*.........:  2302.4 kH/s

---------------------------------------------
* Hash-Mode 11600 (7-Zip) [Iterations: 16384]
---------------------------------------------

Speed.#1.........:  1060.7 kH/s (72.64ms) @ Accel:16 Loops:4096 Thr:256 Vec:1
Speed.#2.........:   870.5 kH/s (73.86ms) @ Accel:32 Loops:4096 Thr:128 Vec:1
Speed.#*.........:  1931.2 kH/s

------------------------------------------------
* Hash-Mode 12500 (RAR3-hp) [Iterations: 262144]
------------------------------------------------

Speed.#1.........:   137.6 kH/s (73.61ms) @ Accel:8 Loops:16384 Thr:256 Vec:1
Speed.#2.........:   100.5 kH/s (40.75ms) @ Accel:4 Loops:16384 Thr:512 Vec:1
Speed.#*.........:   238.1 kH/s

--------------------------------------------
* Hash-Mode 13000 (RAR5) [Iterations: 32799]
--------------------------------------------

Speed.#1.........:   113.7 kH/s (89.05ms) @ Accel:64 Loops:256 Thr:256 Vec:1
Speed.#2.........:    93791 H/s (91.30ms) @ Accel:64 Loops:256 Thr:256 Vec:1
Speed.#*.........:   207.5 kH/s

--------------------------------------------------------------------------------
* Hash-Mode 6211 (TrueCrypt RIPEMD160 + XTS 512 bit (legacy)) [Iterations: 1999]
--------------------------------------------------------------------------------

Speed.#1.........:   792.3 kH/s (93.85ms) @ Accel:64 Loops:128 Thr:256 Vec:1
Speed.#2.........:   646.4 kH/s (48.25ms) @ Accel:32 Loops:64 Thr:512 Vec:1
Speed.#*.........:  1438.7 kH/s

-----------------------------------------------------------------------------------
* Hash-Mode 13400 (KeePass 1 (AES/Twofish) and KeePass 2 (AES)) [Iterations: 24569]
-----------------------------------------------------------------------------------

Speed.#1.........:   139.1 kH/s (48.27ms) @ Accel:8 Loops:1024 Thr:256 Vec:1
Speed.#2.........:    58560 H/s (48.73ms) @ Accel:16 Loops:128 Thr:512 Vec:1
Speed.#*.........:   197.6 kH/s

----------------------------------------------------------------
* Hash-Mode 6800 (LastPass + LastPass sniffed) [Iterations: 499]
----------------------------------------------------------------

Speed.#1.........:  7024.1 kH/s (58.03ms) @ Accel:16 Loops:249 Thr:1024 Vec:1
Speed.#2.........:  5323.7 kH/s (59.12ms) @ Accel:64 Loops:249 Thr:256 Vec:1
Speed.#*.........: 12347.8 kH/s

--------------------------------------------------------------------
* Hash-Mode 11300 (Bitcoin/Litecoin wallet.dat) [Iterations: 200459]
--------------------------------------------------------------------

Speed.#1.........:    13776 H/s (60.02ms) @ Accel:64 Loops:512 Thr:64 Vec:1
Speed.#2.........:    11370 H/s (61.66ms) @ Accel:32 Loops:256 Thr:256 Vec:1
Speed.#*.........:    25146 H/s

Started: Thu Jan 12 15:15:33 2023
Stopped: Thu Jan 12 15:23:30 2023
```
