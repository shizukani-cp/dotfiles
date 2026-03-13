import { BaseConfig } from "https://deno.land/x/ddc_vim@v4.0.4/types.ts";
import { ConfigArguments } from "https://deno.land/x/ddc_vim@v4.0.4/base/config.ts";

export class Config extends BaseConfig {
  override async config(args: ConfigArguments): Promise<void> {
    args.contextBuilder.patchGlobal({
      ui: "native",
      autoCompleteEvents: [
        "InsertEnter",
        "TextChangedI",
        "TextChangedP",
        "CmdlineEnter",
        "CmdlineChanged",
        "TextChangedT",
      ],
      sources: ["denippet", "cmdline", "lsp", "buffer", "file", "path"],
      sourceOptions: {
        _: {
          matchers: ["matcher_fuzzy"],
          sorters: ["sorter_fuzzy"],
          converters: ["converter_fuzzy"],
        },
        buffer: {
          mark: "📃",
        },
        cmdline: {
          mark: "⚙️",
          forceCompletionPattern: "\\S/\\S*|\\.\\w*",
        },
        denippet: {
          mark: "🧩",
        },
        file: {
          mark: "📄",
        },
        lsp: {
          mark: "⚡",
          forceCompletionPattern: "\\.\\w*|::\\w*|->\\w*",
        },
        path: {
          mark: "📁",
        },
        skkeleton: {
          mark: "skkeleton",
          matchers: ["skkeleton"],
          sorters: [],
          minAutoCompleteLength: 1,
          isVolatile: true,
        },
      },
      sourceParams: {
        lsp: {
          debounce: 500,
        },
        path: {
          cmd: ["fd", "--max-depth", "3"],
        },
      },
      filterParams: {
        converter_kind_labels: {
          kindLabels: {
            Text: "󰉿 Text",
            Method: "󰆧 Method",
            Function: "󰊕 Function",
            Constructor: " Constructor",
            Field: "󰜢 Field",
            Variable: "󰀫 Variable",
            Class: "󰠱 Class",
            Interface: " Interface",
            Module: " Module",
            Property: "󰜢 Property",
            Unit: "󰑭 Unit",
            Value: "󰎠 Value",
            Enum: " Enum",
            Keyword: "󰌋 Keyword",
            Snippet: " Snippet",
            Color: "󰏘 Color",
            File: "󰈙 FIle",
            Reference: "󰈇 Reference",
            Folder: "󰉋 Folder",
            EnumMember: " EnumMember",
            Constant: "󰏿 Constant",
            Struct: "󰙅 Struct",
            Event: " Event",
            Operator: "󰆕 Operator",
            TypeParameter: " TypeParameter",
          },
        },
      },
    });

    args.contextBuilder.patchFiletype("skkeleton", {
      sources: ["skkeleton"],
    });
  }
}
