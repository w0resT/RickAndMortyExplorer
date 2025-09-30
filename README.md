# RickAndMortyExplorer

Приложение, которое загружает и отображает персонажей из [The Rick and Morty API](https://rickandmortyapi.com/).

## Описание

- Отображение списка персонажей (пагинация);
- Поиск по имени персонажа;
- Фильтр по статусу и полу персонажа;
- Отображение детальной информации о персонаже.

## Скриншоты

<table>
  <tr>
    <td><img width="150" src="https://github.com/user-attachments/assets/e12cf137-7b94-47a3-bd52-b00777da5eae" alt="Characters screen"></td>
    <td><img width="150" src="https://github.com/user-attachments/assets/8835e9b9-1043-42a9-8a28-d307ebf46d09" alt="Filters"></td>
    <td><img width="150" src="https://github.com/user-attachments/assets/bc9bc642-4d23-4772-bec9-1bcfb736c220" alt="Search with filters"></td>
    <td><img width="150" src="https://github.com/user-attachments/assets/dcf516ab-5d16-464a-8dfb-4e3399965d64" alt="Character details"></td>
  </tr>
</table>

## Начало работы

Перед запуском проекта необходимо сгенерировать ресурсы и проект:

```bash
make generate_resources generate_project
```

### Поддерживаемые команды Makefile

| Команда | Описание |
|--------|----------|
| `make lint` | Запуск SwiftLint |
| `make generate_resources` | Генерация ресурсов через SwiftGen |
| `make generate_project` | Генерация `.xcodeproj` через XcodeGen |
| `make all` | Запуск SwiftLint, генерация ресурсов и проекта |
| `make clean` | Удаление временных папок `build` |

## Архитектура и технологии

- **Архитектура:** MVVM-C
  (UIKit Coordinator, UIKit + SwiftUI Views; DI)
- **Модульность:** SPM
- **Целевая платформа:** iOS 16
- **Инструменты:** SwiftGen, XcodeGen, SwiftLint
- **Технологии:** `URLSession` (async/await), `Combine` (для связи модели и представления), `NSCache` (для изображений)
- **Локализация:** Русский, Английский

Реализована кастомная анимация перехода между экранами Characters (UIKit) и CharacterDetails (SwiftUI).

<table>
  <tr>
    <th>Модуль</th>
    <th>Описание</th>
  </tr>
  <tr>
    <td><code>ApplicationCore</code></td>
    <td>Основные сущности, используемые в приложение: <code>Coordinator</code> (Base), <code>Router</code>, <code>NavigationListener</code>, <code>HostingController</code></td>
  </tr>
  <tr>
    <td><code>ApplicationModule</code></td>
    <td>Основной модуль приложения - <code>ApplicationCoordinator</code></td>
  </tr>
  <tr>
    <td><code>ApplicationResources</code></td>
    <td>Содержит ресурсы для генерации, а также сгенерированные данные (после работы SwiftGen)</td>
  </tr>
  <tr>
    <td><code>Services</code></td>
    <td>
      Содержит сервисы:
      <ul>
        <li><code>CharacterService</code> — получение персонажей;</li>
        <li><code>ImageLoader</code> — загрузка изображений;</li>
        <li><code>NetworkClient</code> — реализация сетевого клиента на основе <code>URLSession</code>.</li>
      </ul>
    </td>
  </tr>
  <tr>
    <td><code>CharacterFeature</code></td>
    <td>
      Модуль персонажей:
      <ul>
        <li><code>Characters</code> — экран отображения персонажей (UIKit);</li>
        <li><code>CharacterDetails</code> — экран отображения информации о персонаже (SwiftUI);</li>
        <li><code>CharacterFilter</code> — экран отображение фильтров (SwiftUI).</li>
      </ul>
    </td>
  </tr>
    <tr>
    <td><code>DesignSystem</code></td>
    <td>Содержит цвета, шрифты, размеры (токены)</td>
  </tr>
</table>
