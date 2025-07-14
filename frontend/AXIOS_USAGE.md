# 🌐 Uso do Axios Global (Composition API)

O Axios foi configurado globalmente no projeto para facilitar as chamadas de API usando Composition API.

## 🚀 Como Usar

### **Composition API (Recomendado)**

```vue
<template>
  <div>
    <button @click="fetchData">Buscar Dados</button>
  </div>
</template>

<script setup>
import { useApi } from '@/composables/useApi'

const api = useApi()

const fetchData = async () => {
  try {
    const response = await api.get('/api/users')
    console.log(response.data)
  } catch (error) {
    console.error('Erro:', error)
  }
}
</script>
```

### **Exemplos de Uso**

```vue
<script setup>
import { useApi } from '@/composables/useApi'

const api = useApi()

// GET
const getUsers = async () => {
  const response = await api.get('/api/users')
  return response.data
}

// POST
const createUser = async (userData) => {
  const response = await api.post('/api/users', userData)
  return response.data
}

// PUT
const updateUser = async (id, userData) => {
  const response = await api.put(`/api/users/${id}`, userData)
  return response.data
}

// DELETE
const deleteUser = async (id) => {
  await api.delete(`/api/users/${id}`)
}
</script>
```

## ⚙️ Configurações Automáticas

### **Base URL**
- Padrão: `http://localhost:3000`
- Configurável via variável de ambiente: `VITE_API_URL`

### **Headers Automáticos**
- `Content-Type: application/json`
- `Authorization: Bearer <token>` (se token existir)

### **Timeout**
- 10 segundos por padrão

## 🔐 Autenticação Automática

O Axios automaticamente:
1. **Adiciona o token** do localStorage em todas as requisições
2. **Remove o token** e redireciona para `/auth` se receber 401

```javascript
// O token é adicionado automaticamente
await api.get('/api/protected-route')
// Headers: Authorization: Bearer eyJhbGciOiJIUzI1NiIs...
```

## 🛠️ Exemplos Práticos

### **Login**
```javascript
const login = async (credentials) => {
  const response = await api.post('/auth/login', credentials)
  localStorage.setItem('token', response.data.token)
  localStorage.setItem('user', JSON.stringify(response.data.user))
  return response.data
}
```

### **Registro**
```javascript
const register = async (userData) => {
  const response = await api.post('/auth/register', userData)
  return response.data
}
```

### **Buscar Dados Protegidos**
```javascript
const getProfile = async () => {
  const response = await api.get('/api/profile')
  return response.data
}
```

## 🚨 Tratamento de Erros

```javascript
try {
  const response = await api.get('/api/data')
  console.log(response.data)
} catch (error) {
  if (error.response) {
    // Erro do servidor (4xx, 5xx)
    console.error('Erro do servidor:', error.response.data)
  } else if (error.request) {
    // Erro de rede
    console.error('Erro de rede:', error.request)
  } else {
    // Outro erro
    console.error('Erro:', error.message)
  }
}
```

## 📝 Variáveis de Ambiente

Crie um arquivo `.env` na pasta `frontend/`:

```env
VITE_API_URL=http://localhost:3000
```

## 🔧 Personalização

Para adicionar interceptors personalizados:

```javascript
// Em src/lib/axios.ts
api.interceptors.request.use((config) => {
  // Seu código aqui
  return config
})

api.interceptors.response.use((response) => {
  // Seu código aqui
  return response
})
``` 