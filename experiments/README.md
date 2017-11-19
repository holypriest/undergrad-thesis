# Experimentos

Existem dois conjuntos de experimentos. O primeiro deles envolvendo a coleta dos tempos de execução de cada implementação, na pasta [execution_times](execution_times/info.md), e o outro envolvendo a comparação das matrizes de saída, em [output_diff](output_diff/info.md)

## Tempos de execução

Na pasta [execution_times](execution_times) você encontrará três programas:

- `mandelexec.sh`: ao executar esse programa, você reproduzirá todos os experimentos realizados ao longo deste trabalho. Atente-se para os comentários existentes nas pastas de código, referentes ao que é necessário para executá-los.

- `speedup.R`: este programa é responsável por gerar a Figura 4 do texto, comparando o _speedup_ entre as implementações. Ele obtém os dados do arquivo `speedup.csv`, que contém os dados coletados ao longo do trabalho. Caso queira gerá-la novamente com os dados obtidos em seu sistema, basta substituir os dados em `speedup.csv`.

- `scheduler.R`: este programa é responsável por gerar a Figura 5 do texto, comparando os diferentes tipos de escalonamento em C/OpenMP. Ele obtém os dados do arquivo `scheduler.csv`, que contém os dados coletados ao longo do trabalho. Caso queira gerá-la novamente com os dados obtidos em seu sistema, basta substituir os dados em `scheduler.csv`.

Os resultados obtidos durante este trabalho estão disponíveis no arquivo `results.tar.gz`.

## Comparação das matrizes de saída

Na pasta [output_diff](output_diff) você encontrará um programa:

- `outcomp.sh`: ao executar esse programa, você reproduzirá todos os experimentos de comparação das matrizes de saída. Caso não obtenha nenhuma saída entre as linhas `(diff)ing ...`, significa que as matrizes de saída geradas são iguais. Mais informações sobre isso podem ser obtidas no texto original.

As matrizes de saída obtidas durante este trabalho estão disponíveis no arquivo `output-files.tar.gz`

## Observações

É necessário possuir o software R instalado em sua máquina, bem como a biblioteca _ggplot2_, que pode ser instalada a partir do comando `install.packages("ggplot2")`.
