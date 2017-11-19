# C/OpenMP

## Execução

### Sequencial

```
gcc complex.c complex.h linspace.c linspace.h [nome_do_arquivo].c -o [nome_do_arquivo]
./[nome_do_arquivo]
```

### Paralelo

```
gcc -fopenmp complex.h linspace.c linspace.h [nome_do_arquivo].c -o [nome_do_arquivo]
./[nome_do_arquivo]
```

### Modo de exportação da matriz de saída

Para exportar a matriz de saída, basta rodar qualquer um dos comandos de execução acima (./[nome_do_arquivo]) com a flag `-export` no final.
