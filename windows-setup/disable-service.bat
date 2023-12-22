# https://ygkb.jp/22889

#BitLocker Drive Enctyption Service
sc.exe stop BDESVC
sc.exe config BDESVC start=disabled

#Block Level Backup Engine Service
sc.exe stop wbengine
sc.exe config wbengine start=disabled

#Bluetooth オーディオ ゲートウェイ サービス
sc.exe stop BTAGService
sc.exe config BTAGService start=disabled

#Bluetooth サポート サービス
sc.exe stop bthserv
sc.exe config bthserv start=disabled

#Diagnostic Policy Service
sc.exe stop DPS
sc.exe config DPS start=disabled

#Diagnostic Service Host
sc.exe stop WdiServiceHost
sc.exe config WdiServiceHost start=disabled

#Diagnostic System Host
sc.exe stop WdiSystemHost
sc.exe config WdiSystemHost start=disabled

#SensorDataService
sc.exe stop SensorDataService
sc.exe config SensorDataService start=disabled

#Sensor Monitoring Service
sc.exe stop SensrSvc
sc.exe config SensrSvc start=disabled

#Sensor Service
sc.exe stop SensorService
sc.exe config SensorService start=disabled

#Windows Image Acquisition (WIA)
sc.exe stop StiSvc
sc.exe config StiSvc start=disabled
