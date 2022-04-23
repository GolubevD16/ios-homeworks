//
//  postData.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 10.11.2021.
//

import Foundation
import StorageService

class PostModel {
    
    static func getPosts() -> [Post] {
        let posts = [
            Post(
                author: "vedmak.official",
                description: "Новые кадры со съемок второго сезона сериала 'Ведьмак'",
                image: "vedmak",
                likes: 240,
                views: 312
            ),
            Post(
                author: "Нетология. Меряем карьеру через образование.",
                description: "От ' Hello, World' до первого сложного iOS-приложения - всего один курс. Если чувствуете в себе силу для покорения топов AppStore - пора начинать действовать! Профессия 'iOS-разработчик' - тот самый путь, по которому стоит пройти до самого конца. Вы научитесь создавать приложения на языке Swift с нуля: от начинки до интерфейса. Чтобы закрепить знания на практике, каждый студент подготовит дипломную работу - VK-like приложения с возможностью публиковать фотографии, использовать фильтры, ставить лайки и подписываться на других пользователей",
                image: "netology",
                likes: 766,
                views: 893
            ),
            Post(
                author: "kommersant.ru",
                description: "Российские власти обсуждают техническую возможность введения системы QR-кодов в самолетах и поездах, сообщил РБК со ссылкой на двух федеральных чиновников и несколько источников в транспортной отрасли. Окончательное решение на этот счет еще не принято, говорится в сообщении, все будет зависеть от эпидемической обстановки.",
                image: "QR",
                likes: 3,
                views: 18000
            ),
            Post(
                author: "iz.ru",
                description: "Владельцы iPhone и iPad теперь могут подвязать карту «Мир» к учетной записи Apple и оплачивать ей различные сервисы экосистемы — например, подписку в Apple Music, Apple TV и Apple Podcasts, а также приложения в App Store, узнали «Известия». Для этого в меню «способы платежа» нужно выбрать пункт «оплата картой». Раньше в этом пункте уточнялось, что можно использовать только Visa, Mastercard и American Express. В ноябре в меню также появились карты «Мир».",
                image: "mir",
                likes: 1234,
                views: 12345
            )
        ]
        return posts
    }
}