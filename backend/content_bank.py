"""Loads, deduplicates, and searches the original SpeakLocal Markdown banks."""
from __future__ import annotations
import re
from pathlib import Path

class ContentBank:
    def __init__(self, vocabulary_path: Path, expressions_path: Path):
        self.paths = [
            (vocabulary_path, "vocabulary", "Word", "English Definition", "English Example"),
            (expressions_path, "expression", "Expression", "English Meaning", "Example Sentence"),
        ]
        self.entries: list[dict[str, str]] = []
        self.stats = {"vocabulary": 0, "expressions": 0, "total": 0}

    @staticmethod
    def _field(block: str, label: str) -> str:
        match = re.search(r"^- \\*\\*" + re.escape(label) + r":\\*\\*\\s*(.*)$", block, re.MULTILINE)
        return match.group(1).strip() if match else ""

    @staticmethod
    def _normalize(value: str) -> str:
        value = re.sub(r"\\s*\\([^)]*\\)$", "", value)
        return re.sub(r"\\s+", " ", value).strip().casefold()

    def load(self) -> None:
        unique = {}
        for path, kind, prompt_label, meaning_label, example_label in self.paths:
            if not path.is_file():
                raise RuntimeError(f"Learning bank file is missing: {path.name}")
            blocks = re.split(r"(?=^### Entry\\s+\\d+:)", path.read_text(encoding="utf-8"), re.MULTILINE)
            for block in blocks:
                if not block.lstrip().startswith("### Entry"):
                    continue
                prompt, meaning = self._field(block, prompt_label), self._field(block, meaning_label)
                if not prompt or not meaning:
                    continue
                clean = re.sub(r"\\s*\\([^)]*\\)$", "", prompt).strip()
                unique.setdefault((kind, self._normalize(clean)), {
                    "kind": kind, "prompt": clean, "meaning": meaning,
                    "arabic": self._field(block, "Arabic Definition") or self._field(block, "Arabic Meaning"),
                    "example": self._field(block, example_label).strip('"“”'),
                })
        self.entries = list(unique.values())
        self.stats = {
            "vocabulary": sum(e["kind"] == "vocabulary" for e in self.entries),
            "expressions": sum(e["kind"] == "expression" for e in self.entries),
            "total": len(self.entries),
        }
        if not self.entries:
            raise RuntimeError("No valid learning entries were found in the Markdown banks.")

    def find_relevant(self, query: str, limit: int = 8) -> list[dict[str, str]]:
        words = set(re.findall(r"[a-zA-Z]{3,}", query.casefold()))
        if not words:
            return self.entries[:limit]
        scored = []
        for index, entry in enumerate(self.entries):
            searchable = " ".join((entry["prompt"], entry["meaning"], entry["example"])).casefold()
            score = len(words & set(re.findall(r"[a-zA-Z]{3,}", searchable)))
            if score:
                scored.append((score, -index, entry))
        scored.sort(key=lambda item: (item[0], item[1]), reverse=True)
        return [item[2] for item in scored[:limit]]
