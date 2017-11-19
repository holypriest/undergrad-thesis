# Códigos

O algoritmo de obtenção do conjunto de Mandelbrot foi implementado em 4 linguagens diferentes:

- [Go](go/info.md)
- [Julia](julia/info.md)
- [Python](python/info.md)
- [C/OpenMP](c-openmp/info.md)

sendo que, em Julia, foram experimentados dois paradigmas de programação: funcional e imperativo

## Para executar os códigos foram utilizados:

### Go

- Go versão 1.7.6

### Julia

- Julia versão 0.6

### Python

- Python versão 3.6.1
- Bibliotecas numpy e matplotlib
- Arquivo `.matplotlib/matplotlibrc` em sua _home folder_, contendo as configurações de exibição e exportação de figuras (existe um exemplo funcional na pasta python)

### C/OpenMP

- Compilador GCC versão 7.2.0 com suporte a OpenMP

### Variáveis de ambiente

```
# Número de linhas da matriz de entrada
INPUTMAT_ROWS=

# Número de colunas da matriz de entrada
INPUTMAT_COLS=

# Número máximo de núcleos de processamento
NUM_THREADS=

# Tamanho do pacote de tarefas (chunk size) para execuções em C/OpenMP
SCHED_CHUNK_SIZE=
```

### Comentários gerais

Não é garantido que outras versões das linguagens funcionem de maneira correta devido a pequenas diferenças nas implementações (esta questão é abordada no texto).
