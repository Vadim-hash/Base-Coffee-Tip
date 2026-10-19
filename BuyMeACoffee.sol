// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract BuyMeACoffee {
    // Событие для отслеживания новых записей
    event NewMemo(
        address indexed from,
        uint256 timestamp,
        string name,
        string message,
        uint256 amount
    );

    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
        uint256 amount;
    }

    address payable public immutable owner;
    Memo[] private memos;

    constructor() {
        owner = payable(msg.sender);
    }

    /**
     * @dev Оставить чаевые и сообщение
     * @param _name Имя отправителя
     * @param _message Сообщение
     */
    function buyCoffee(string calldata _name, string calldata _message) external payable {
        require(msg.value > 0, unicode"Чаевые должны быть больше 0 ETH");

        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message,
            msg.value
        ));

        emit NewMemo(
            msg.sender,
            block.timestamp,
            _name,
            _message,
            msg.value
        );

        // Переводим средства владельцу контракта
        (bool success, ) = owner.call{value: msg.value}("");
        require(success, unicode"Не удалось перевести средства");
    }

    /**
     * @dev Получить все оставленные сообщения
     */
    function getMemos() external view returns (Memo[] memory) {
        return memos;
    }
}