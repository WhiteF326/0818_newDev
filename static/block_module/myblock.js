Blockly.defineBlocksWithJsonArray(
  [{
    'type': 'move',
    'message0': '%1 に進む %2',
    'args0': [
      {
        'type': 'field_dropdown',
        'name': 'vector',
        'options': [
          [
            '左',
            'LEFT',
          ],
          [
            '右',
            'RIGHT',
          ],
          [
            '上',
            'BACK',
          ],
          [
            '下',
            'FRONT',
          ],
        ],
      },
      {
        'type': 'input_value',
        'name': 'NAME',
        'check': 'String',
      },
    ],
    'previousStatement': null,
    'nextStatement': null,
    'colour': 0,
    'tooltip': '指定した方向に1歩進みます。',
    'helpUrl': '',
  },
  {
    'type': 'destroy',
    'message0': '足元の岩を破壊する',
    'previousStatement': null,
    'nextStatement': null,
    'colour': 60,
    'tooltip': '足元の岩を破壊します',
    'helpUrl': '',
  },
  {
    'type': 'create',
    'message0': '足元に岩を置く',
    'previousStatement': null,
    'nextStatement': null,
    'colour': 120,
    'tooltip': '足元に岩を置きます。',
    'helpUrl': '',
  },
  {
    'type': 'repair',
    'message0': '壊れる床の耐久値 + 1',
    'previousStatement': null,
    'nextStatement': null,
    'colour': 150,
    'tooltip': '足元の壊れる床の耐久値を1増やします',
    'helpUrl': '',
  },
  {
    'type': 'loop',
    'message0': '%1 回繰り返し実行 %2 %3',
    'args0': [
      {
        'type': 'field_number',
        'name': 'REPEATAMOUNT',
        'value': 0,
        'min': 0,
        'precision': 1,
      },
      {
        'type': 'input_value',
        'name': 'REPEATAMOUNT',
        'check': 'Number',
      },
      {
        'type': 'input_statement',
        'name': 'REPEATBLOCK',
      },
    ],
    'previousStatement': null,
    'nextStatement': null,
    'colour': 180,
    'tooltip': '中に含まれるブロックを繰り返し実行します。',
    'helpUrl': '',
  },
  {
    'type': 'if',
    'message0': '判定する条件 %1 正しい時の処理 %2 正しくない時の処理 %3',
    'args0': [
      {
        'type': 'input_value',
        'name': 'STATEMENT',
      },
      {
        'type': 'input_statement',
        'name': 'TRUE',
      },
      {
        'type': 'input_statement',
        'name': 'FALSE',
      },
    ],
    'previousStatement': null,
    'nextStatement': null,
    'colour': 240,
    'tooltip': '条件により分岐します。',
    'helpUrl': '',
  },
  {
    "type": "sensor_loop",
    "message0": "ループ %1 回目かそれより後である %2",
    "args0": [
      {
        "type": "field_number",
        "name": "COUNTER",
        "value": 0,
        "min": 0
      },
      {
        "type": "input_value",
        "name": "LOOP_COUNT"
      }
    ],
    "output": "Boolean",
    "colour": 300,
    "tooltip": "今回っているループが指定回数目かそれ以降ならば真を返します。",
    "helpUrl": ""
  },
  {
    'type': 'sensor_foot',
    'message0': '足元が壊せる岩である',
    'output': 'Boolean',
    'colour': 300,
    'tooltip': 'キャラクターの足元が壊せる岩ならば真を返します。',
    'helpUrl': '',
  },
],
);

Blockly.JavaScript['move'] = function(block) {
  const dropdown_vector = block.getFieldValue('vector');
  const value_name = Blockly.JavaScript.valueToCode(block, 'NAME', Blockly.JavaScript.ORDER_ATOMIC);
  const code = "move " + dropdown_vector.toLowerCase() + "\n";
  return code;
};

Blockly.JavaScript['destroy'] = function(block) {
  const code = 'destroy\n';
  return code;
};

Blockly.JavaScript['create'] = function(block) {
  const code = 'create\n';
  return code;
};

Blockly.JavaScript['repair'] = function(block) {
  const code = 'repair\n';
  return code;
}

Blockly.JavaScript['loop'] = function(block) {
  const number_repeatamount = block.getFieldValue('REPEATAMOUNT');
  const value_repeatamount = Blockly.JavaScript.valueToCode(block, 'REPEATAMOUNT', Blockly.JavaScript.ORDER_ATOMIC);
  const statements_repeatblock = Blockly.JavaScript.statementToCode(block, 'REPEATBLOCK');
  const forid = String(Math.random());
  const code = 'loop ' + number_repeatamount + ' ' + forid + '\n' + statements_repeatblock + 'next ' + forid + '\n';
  return code;
};

Blockly.JavaScript['if'] = function(block) {
  const statements_statement = Blockly.JavaScript.statementToCode(block, 'STATEMENT');
  const statements_true = Blockly.JavaScript.statementToCode(block, 'TRUE');
  const statements_false = Blockly.JavaScript.statementToCode(block, 'FALSE');
  const ifid = String(Math.random());
  const code = 'if ' + statements_statement + ' ' + ifid + '\n' + statements_true + 'else ' + ifid + '\n' + statements_false + 'endif ' + ifid + '\n';
  return code;
};

Blockly.JavaScript['sensor_foot'] = function(block) {
  const code = 'sensor_foot';
  return code;
}

Blockly.JavaScript['sensor_loop'] = function(block) {
  const number_name = block.getFieldValue('COUNTER');
  const code = 'sensor_loop ' + number_name;
  return code;
}