# SA Registros - Sistema de Registro de Ponto

Um aplicativo Flutter para registro de ponto de trabalho com autenticação Firebase e geolocalização.

## 📋 Sobre o Projeto

O SA Registros é um sistema mobile desenvolvido em Flutter que permite aos funcionários registrar seus pontos de entrada e saída do trabalho. O aplicativo utiliza autenticação Firebase para segurança e geolocalização para validar se o usuário está dentro da área de trabalho permitida.

## 🚀 Funcionalidades

### Autenticação
- ✅ **Login com Email/Senha**: Autenticação segura via Firebase Auth
- ✅ **Criação de Conta**: Formulário completo com validações
- ✅ **Logout**: Encerramento seguro da sessão

### Registro de Ponto
- ✅ **Registro de Entrada/Saída**: Marcação de ponto com data e hora
- ✅ **Validação de Localização**: Verificação se o usuário está dentro de 100m do local de trabalho
- ✅ **Histórico**: Visualização de todos os registros realizados

### Segurança e Validação
- ✅ **Autenticação Firebase**: Sistema robusto de autenticação
- ✅ **Geolocalização**: Controle de presença baseado em localização GPS
- ✅ **Validações**: Campos obrigatórios e formatos corretos

## 🛠️ Tecnologias Utilizadas

- **Flutter**: Framework para desenvolvimento mobile
- **Firebase Auth**: Autenticação de usuários
- **Cloud Firestore**: Banco de dados NoSQL
- **Geolocator**: Serviços de geolocalização
- **Provider**: Gerenciamento de estado

## 📱 Estrutura do Projeto

```
lib/
├── main.dart                 # Ponto de entrada da aplicação
├── firebase_options.dart     # Configurações do Firebase
├── screens/
│   ├── login_screen.dart     # Tela de login
│   ├── signup_screen.dart    # Tela de criação de conta
│   ├── home_screen.dart      # Tela principal após login
│   ├── registro_screen.dart  # Tela de registro de ponto
│   └── historico_screen.dart # Tela de histórico
├── services/
│   ├── auth_service.dart     # Serviço de autenticação
│   ├── firebase_service.dart # Serviço do Firestore
│   └── location_service.dart # Serviço de localização
└── widgets/
    └── custom_button.dart    # Componente de botão personalizado
```

## 🔧 Configuração e Instalação

### Pré-requisitos
- Flutter SDK (versão 3.9.2 ou superior)
- Android Studio ou VS Code
- Conta Google (para Firebase)
- Dispositivo Android ou emulador

### Configuração do Firebase

1. **Criar projeto no Firebase Console:**
   - Acesse [Firebase Console](https://console.firebase.google.com/)
   - Crie um novo projeto
   - Ative Authentication e Firestore

2. **Configurar Authentication:**
   - Vá para Authentication > Sign-in method
   - Ative "Email/Password"
   - Adicione o SHA-1 do seu keystore de debug

3. **Configurar Firestore:**
   - Vá para Firestore Database
   - Crie um banco de dados
   - Configure as regras de segurança

4. **Adicionar app Android:**
   - Baixe o `google-services.json`
   - Coloque em `android/app/`

### Instalação

1. **Clone o repositório:**
   ```bash
   git clone <url-do-repositorio>
   cd sa_registros
   ```

2. **Instale as dependências:**
   ```bash
   flutter pub get
   ```

3. **Configure o Firebase:**
   - Substitua o `google-services.json` pelo seu arquivo
   - Atualize `firebase_options.dart` se necessário

4. **Execute o app:**
   ```bash
   flutter run
   ```

## 📋 Como Usar

### Primeiro Acesso
1. Abra o aplicativo
2. Clique em "Criar Conta"
3. Preencha o formulário com email e senha
4. Faça login com suas credenciais

### Registrando Ponto
1. Na tela inicial, clique em "Registrar Ponto"
2. Aguarde a verificação de localização
3. Quando estiver dentro da área, clique em "Registrar Ponto"

### Visualizando Histórico
1. Na tela inicial, clique em "Ver Histórico"
2. Visualize todos os seus registros de ponto

## 🔒 Regras de Segurança

### Firestore Rules
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Apenas usuários autenticados podem acessar seus próprios dados
    match /registros/{userId}/{document=**} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

### Localização Permitida
- **Latitude**: -23.550520 (São Paulo - exemplo)
- **Longitude**: -46.633308 (São Paulo - exemplo)
- **Raio**: 100 metros

## 🐛 Troubleshooting

### Problemas Comuns

**Erro de autenticação:**
- Verifique se o SHA-1 está correto no Firebase Console
- Confirme se o `google-services.json` está atualizado

**Erro de localização:**
- Permita acesso à localização nas configurações do dispositivo
- Verifique se o GPS está ativado

**Build falhando:**
- Execute `flutter clean` e `flutter pub get`
- Verifique se todas as dependências estão instaladas

## 📄 Licença

Este projeto é propriedade da organização SA. Todos os direitos reservados.

## 👥 Contribuição

Para contribuir com o projeto:
1. Faça um fork do repositório
2. Crie uma branch para sua feature (`git checkout -b feature/nova-funcionalidade`)
3. Commit suas mudanças (`git commit -am 'Adiciona nova funcionalidade'`)
4. Push para a branch (`git push origin feature/nova-funcionalidade`)
5. Abra um Pull Request

## 📞 Suporte

Para suporte técnico, entre em contato com a equipe de desenvolvimento.
