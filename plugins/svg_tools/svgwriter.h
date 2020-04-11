/*
 * This file is part of Clayground (https://github.com/MisterGC/clayground)
 *
 * This software is provided 'as-is', without any express or implied warranty.
 * In no event will the authors be held liable for any damages arising from
 * the use of this software.
 *
 * Permission is granted to anyone to use this software for any purpose,
 * including commercial applications, and to alter it and redistribute it
 * freely, subject to the following restrictions:
 *
 * 1. The origin of this software must not be misrepresented; you must not
 *    claim that you wrote the original software. If you use this software in
 *    a product, an acknowledgment in the product documentation would be
 *    appreciated but is not required.
 *
 * 2. Altered source versions must be plainly marked as such, and must not be
 *    misrepresented as being the original software.
 *
 * 3. This notice may not be removed or altered from any source distribution.
 *
 * Authors:
 * Copyright (c) 2019 Serein Pfeiffer <serein.pfeiffer@gmail.com>
 */
#ifndef CLAY_SVG_WRITER_H
#define CLAY_SVG_WRITER_H 

#include <QObject>
#include <QFile>
#include <QPointF>
#include <QList>
#include <memory>

namespace simple_svg {class Document;}

class SvgWriter: public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString path READ path WRITE setPath NOTIFY pathChanged)

public:
    SvgWriter();
    ~SvgWriter();

public slots:
    void begin(float widthWu, float heightWu);

    void rectangle(double x,
                   double y,
                   double width,
                   double height, const QString& description);

    void circle(double x,
                double y,
                double radius, const QString& description);

    void polygon(QVariantList points,
            const QString& description);

    void polyline(QVariantList points,
            const QString& description);

    void end();

signals:
    void pathChanged();

private:
    void setPath(const QString& pathToSvg);
    QString path() const;

private:
    std::unique_ptr<simple_svg::Document> document_;
    QString pathToSvg_;
};
#endif