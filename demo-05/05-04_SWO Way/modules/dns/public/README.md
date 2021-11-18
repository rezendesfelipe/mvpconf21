# Módulo de Private DNS

## Variáveis válidas (DNS Private)

* [Obrigatório] `resource_group_name`: Compõe o nome da VM e recursos associados de acordo com o documento de nomenclatura.
* [Obrigatório] `name`: O nome da zona DNS privada. Deve ser um nome de domínio válido.
* [Obrigatório] `tags`: Um mapeamento de tags para atribuir ao recurso.

## Ouputs gerados pelo módulo

* `zone_name`: Nome da zona criada
* `a_records`: Nomes dos A records
* `cname_records`: Nomes dos CNAME records

### Exemplo de código

Terraform 0.14.x

```Go
module "dns-private" {
  source = "../../../../modules/dns/public"
  resource_group_name = azurerm_resource_group.rg.name
  name = "onsite.com"
  
  a_records = [
    {
      name = "cassandra"
      ttl = 3600
      records = ["10.8.18.4"]
    },
    {
      name = "cassandra2"
      ttl = 3600
      records = ["10.8.18.5"]
    }
  ]
  cname_records = [
    {
      name = "cassandra3"
      ttl = 3600
      record = "contoso.com"
    }
  ]
  tags = {
    team = "onsite"
    suite = "impulse"
    product = "onsite"
    env = "dev"
    provisioner = "terraform"
  }
}
```
### Exemplo de loop dos records:

Terraform 0.14.x

```Go
a_records = [
    {
      name = "cassandra"
      ttl = 3600
      records = ["10.8.18.4"]
    },
    {
      name = "cassandra2"
      ttl = 3600
      records = ["10.8.18.5"]
    }
  ]
  cname_records = [
    {
      name = "cassandra3"
      ttl = 3600
      record = "contoso.com"
    }
  ]
```
Clique [**aqui**]([../../README.md](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link)) para voltar para a página principal da documentação.
