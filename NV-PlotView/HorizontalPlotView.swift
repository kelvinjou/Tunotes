//
//  HorizontalPlotView.swift
//  PlotView
//
//  Created by James Bean on 6/27/17.
//
//



public protocol HorizontalPlotView: PlotView {
    associatedtype Model: HorizontalPlotModel
    func concreteHorizontalPosition(for coordinate: Model.HorizontalAxis.Coordinate) -> Double
}
