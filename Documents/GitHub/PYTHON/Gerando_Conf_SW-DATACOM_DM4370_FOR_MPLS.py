import os
from datetime import datetime

def obter_entrada_usuario(pergunta, padrao=""):
    # Função para obter entrada do usuário com opção de valor padrão
    entrada = input(f"{pergunta} [{padrao}]: ").strip()
    return entrada if entrada else padrao

def substituir_palavras_chave(caminho_arquivo):
    # Solicitar informações ao usuário
    Nova_VLAN_de_LAN = obter_entrada_usuario("Qual a VLAN FTTH da cidade similar >> 200 ?")
    Nome_da_Cidade = obter_entrada_usuario("Qual nome da cidade desse SW?")
    Nova_VLAN_de_TRANSPORTE = obter_entrada_usuario("Qual a VLAN de TRANSPORTE?")
    Novo_Nome_TRASN_PARCEIRO = obter_entrada_usuario("Entre com o nome similar > TRANS.LINKBRASIL")
    Novo_Nome_LINK_PARCEIRO = obter_entrada_usuario("Entre com o nome similar > LINK.GIGANET")
    Entre_com_ip_brod_lan = obter_entrada_usuario("Novo IP/Máscara (172.23.50.1/23)LAN-BRODCAST", "NOVO_IP/NOVA_MASCARA")
    Entre_com_ip_ptp_wan = obter_entrada_usuario("Novo IP/Máscara (172.23.0.46/30)WAN-PTP" , "NOVO_IP/NOVA_MASCARA")
    Entre_com_ip_Loopback = obter_entrada_usuario("Entre com novo IP de Loopback similar > (172.23.49.1/32)", "NOVO_IP")
    Entre_com_ip_RouterID = obter_entrada_usuario("Entre com novo IP de RouterID similar > (172.23.49.1)", "NOVO_IP")
    Entre_com_rede_cidade = obter_entrada_usuario("Entre com novo Range da rede similar > (172.23.48.0/22)", "NOVO_IP/NOVA_MASCARA")
    nova_area_OSPF = obter_entrada_usuario("Qual numero da nova area OSPF?", "nova_area_OSPF")
    Entre_com_range_rede_cidade = obter_entrada_usuario("Entre com novo Range da rede similar > (172.23.48.0 255.255.252.0)", "NOVO_IP NOVA_MASCARA")

    # Palavras-chave a serem substituídas e suas novas entradas
    substituicoes = {
        'xxx': Nova_VLAN_de_LAN,
        'NOMECIDADE': Nome_da_Cidade,
        'yyy': Nova_VLAN_de_TRANSPORTE,
        'TRANS.NOME': Novo_Nome_TRASN_PARCEIRO,
        'LINK.NOME': Novo_Nome_LINK_PARCEIRO,
        '172.23.cli.1/23': Entre_com_ip_brod_lan,
        '172.23.0.ptp/30': Entre_com_ip_ptp_wan,
        '172.23.loop.1/32': Entre_com_ip_Loopback,
        '172.23.rd.1': Entre_com_ip_RouterID,
        '172.23.cidr.0/22': Entre_com_rede_cidade,
        'areaid': nova_area_OSPF,
        '172.23.zzz.0 255.255.252.0': Entre_com_range_rede_cidade,
    }

    # Verifica se o arquivo existe
    if not os.path.exists(caminho_arquivo):
        print(f"Arquivo {caminho_arquivo} não encontrado.")
        return

    # Lê o conteúdo do arquivo
    with open(caminho_arquivo, 'r') as arquivo:
        conteudo = arquivo.read()

    # Substitui as palavras-chave
    for chave, valor in substituicoes.items():
        conteudo = conteudo.replace(chave, valor)

    # Obtém a data atual para incluir no nome do novo arquivo
    data_atual = datetime.now().strftime("%Y%m%d_%H%M%S")
    novo_arquivo = f"{Nome_da_Cidade}_{data_atual}.txt"

    # Escreve o conteúdo modificado em um novo arquivo
    with open(novo_arquivo, 'w') as arquivo:
        arquivo.write(conteudo)

    print(f"Substituições concluídas. Novo arquivo gerado: {novo_arquivo}")

# Caminho do arquivo padrao.txt 
caminho_arquivo = r'G:\Outros computadores\Computador Serviço\EVANDRO\VISUAL STUDIO\DATACOM\padrao-dourados.txt'

# Chama a função para substituir as palavras-chave e gerar um novo arquivo
substituir_palavras_chave(caminho_arquivo)

