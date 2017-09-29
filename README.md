This project is for Chinese IME, thus this document is written in Chinese.

这是一个自动下载搜狗输入法的[细胞词库](http://pinyin.sogou.com/dict/)并转换为 `RIME` 词库的脚本。

如何使用
---

拷贝 `config.example` 到 `config` 文件，修改其中的数组 `DICT_IDS` `DICT_NAMES` `DICT_MASTER_NAME` 和 `DICT_SHORTS`。

其中，`DICT_IDS` 代表细胞词库的 ID，可以从细胞词库的详情页面URL中获取（例如 `http://pinyin.sogou.com/dict/detail/index/15117?rf=dictindex` 中的 `15117` 就是 ID）

`DICT_NAMES` 即为细胞词库的名称，请直接从网页上复制（带有 `官方推荐` 字样的也要完整复制，那也是名称中的一部分）

`DICT_SHORTS` 是词库的短名称，将用作词库文件名的一部分，所以请务必确保其中的字符都是文件系统允许的字符。

`DICT_MASTER_NAME` 是主词库的名称。由于各个词库都被放入独立的词典文件，而RIME只能指定一个输入法使用一个词库，所以脚本会生成一个主词典文件，通过 `import_tables` 导入其他所有生成的词典。这样，只要在RIME配置里直接引用这个主词典文件就可以了。

还有一个配置项，`DICT_PREFIX`，将其改为你主要使用的输入法名称即可。不修改也没有太大的问题 —— 这仅仅用作文件名的一部分而已。

完成以后运行 `fetch.sh`，脚本退出以后，生成的词库文件就在 `out/rime` 里面了。你也可以设置 `COPY` 配置项来让脚本执行完成之后自动部署字典文件到 `RIME` 目录下。

另外有一个选项 `HOOK_AFTER`，可以用于在脚本执行完成后执行自定义命令，比如自动重新部署RIME。

要让RIME使用生成的词库，只需要将 `out/rime` 下所有东西复制到 RIME 配置目录，然后编辑 `输入法名.custom.yaml`

```yaml
patch:
  "translator/dictionary": DICT_PREFIX.DICT_MASTER_NAME
```

将其中 `DICT_PREFIX` 和 `DICT_MASTER_NAME` 换成你自己在 `config` 里面定义的值然后重新部署 RIME 即可。
