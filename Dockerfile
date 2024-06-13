# Utilizando a imagem oficial do .NET SDK para compilar a aplicação
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /app

# Copiando os arquivos da aplicação e restaurando as dependências
COPY src/*.csproj ./
RUN dotnet restore

# Copiando todos os arquivos e construindo a aplicação
COPY src/. ./
RUN dotnet publish -c Release -o out

# Utilizando a imagem oficial do .NET runtime para executar a aplicação
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
COPY --from=build /app/out .

# Expondo a porta em que a aplicação irá rodar
EXPOSE 80
# Comando para rodar a aplicação
ENTRYPOINT ["dotnet", "poc-prometheus.dll"]