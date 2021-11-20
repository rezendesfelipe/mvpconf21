# 3. Definição de taxonomia das branches

Data: 2021-11-11

## Status

Aceito

## Context

Precisamos documentar a maneira na qual as branches do repositório serão criadas para deixar claro tudo o que foi trabalhado no repositório em relação ao projeto.

## Decision

O padrão de nomeação das branches segue o modelo a seguir:

```<Tipo de Work Item>/<Id do Workitem>-<descricao>```

Para tanto o seguinte padrão será adotado, de acordo com os itens de trabalho existentes neste projeto: 

|Work Item|Padrão de Branch|
|--|--|
|Feature|FT|
|Backlog Item|BI|
|Task|TK|
|Bug|BG|

Exemplos:

- ```TK/1234-task-do-boards```
<br>
- ```BI/4321-backlog-item-do-boards```

Nos exemplos acima, "TK" e "BI" representam os tipos de seus work items, sendo "Task" e "Backlog Item", respectivamente. Logo após, o número que representa o ID do work item pode ser visto acompanhado de sua respectiva descrição.

## Consequences

Ao padronizar a forma como as branches serão criadas adotando a maneira proposta, tudo que foi feito no repositório em relação aos work items será facilmente identificável e claro.